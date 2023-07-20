* Tabela Transparente
tables zt005.

* Tabelas Internas
data: t_zt005    type table of zt005,
      t_zt001    type table of zt001,
      t_saida    type table of zs001,
      t_fieldcat type slis_t_fieldcat_alv,
      t_sort     type slis_t_sortinfo_alv,
      t_header   type slis_t_listheader.

* Works Areas
data: w_zt005    type zt005,
      w_zt001    type zt001,
      w_saida    type zs001,
      w_fieldcat type slis_fieldcat_alv,
      w_sort     type slis_sortinfo_alv,
      w_layout   type slis_layout_alv,
      w_header   type slis_listheader.

* Telas de seleção
selection-screen begin of block bloco01 with frame title text-001.
select-options: s_tpmat for zt005-tpmat,
                s_mater for zt005-mater.
selection-screen end of block bloco01.

selection-screen begin of block bloco02 with frame title text-002.
parameters variant type slis_vari.
selection-screen end of block bloco02.

* Bloco de execução
start-of-selection.
  perform select.               " Seleção dos registros

  perform monta_tabela_saida.   " Montagem da tabela de saida

  perform monta_alv.            " Montagem do ALV

form select .

  select * from zt005
    into table t_zt005
    where tpmat in s_tpmat and mater in s_mater.

  if sy-subrc is initial.

    select * from zt001
      into table t_zt001
       for all entries in t_zt005
     where tpmat = t_zt005-tpmat.
  else.

    message text-003 type 'I'.
    stop.
  endif.

endform.

form monta_tabela_saida .

  loop at t_zt005 into w_zt005.
    w_saida-mater    = w_zt005-mater.
    w_saida-tpmat    = w_zt005-tpmat.
    w_saida-denom    = w_zt005-denom.

    read table t_zt001 into w_zt001 with key tpmat = w_zt005-tpmat.
    w_saida-denom_tp = w_zt001-denom.

    w_saida-brgew    = w_zt005-brgew.
    w_saida-ntgew    = w_zt005-ntgew.
    w_saida-gewei    = w_zt005-gewei.
    w_saida-status   = w_zt005-status.

    append w_saida to t_saida.
  endloop.

endform.

form monta_alv .

  perform fieldcat. " Definição da fieldcat

  perform ordena.   " Ordenando a leitura dos registros

  perform layout.   " Ajustando o layout

  perform imprimir. " Imprimindo os registros

endform.

form fieldcat .

  call function 'REUSE_ALV_FIELDCATALOG_MERGE'
    exporting
      i_program_name         = sy-repid         " Id do programa
      i_internal_tabname     = 't_saida'        " Tabela interna de saida dos registros
      i_structure_name       = 'zs001'          " Estrutura da tabela de saida dos registros
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_INCLNAME             =
*     I_BYPASSING_BUFFER     =
*     I_BUFFER_ACTIVE        =
    changing
      ct_fieldcat            = t_fieldcat       " Tabela de fieldcat que armazena os registros de impressão
    exceptions
      inconsistent_interface = 1
      program_error          = 2
      others                 = 3.

  if sy-subrc <> 0.

    message text-004 type 'I'.
    stop.
  else.

* Tratamento dos nomes de alguns campos
    loop at t_fieldcat into w_fieldcat.

      case w_fieldcat-fieldname.
        when 'BRGEW'.
          w_fieldcat-seltext_l = w_fieldcat-seltext_m = w_fieldcat-seltext_s = w_fieldcat-reptext_ddic = text-005.
        when 'NTGEW'.
          w_fieldcat-seltext_l = w_fieldcat-seltext_m = w_fieldcat-seltext_s = w_fieldcat-reptext_ddic = text-006.
        when others.
      endcase.

      modify t_fieldcat from w_fieldcat index sy-tabix transporting seltext_l seltext_m seltext_s reptext_ddic .
    endloop.
  endif.



endform.

form ordena .

* Limpando a tabela e a work area
  clear w_sort.

* Ordenando pelo campo material
  w_sort-spos      = 1.
  w_sort-fieldname = 'MATER'.
  w_sort-tabname   = 't_saida'.
  w_sort-up        = 'X'.
  append w_sort to t_sort.

endform.

form layout .

  w_layout-zebra             = 'X'.
  w_layout-colwidth_optimize = 'X'.

endform.

form imprimir .

  call function 'REUSE_ALV_GRID_DISPLAY'
    exporting
*     I_INTERFACE_CHECK      = ' '
*     I_BYPASSING_BUFFER     = ' '
*     I_BUFFER_ACTIVE        = ' '
      i_callback_program     = sy-repid             " Id do programa
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
      i_callback_top_of_page = 'CABECALHO'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME       =
*     I_BACKGROUND_ID        = ' '
*     I_GRID_TITLE           =
*     I_GRID_SETTINGS        =
      is_layout              = w_layout             " Layout de impressão
      it_fieldcat            = t_fieldcat           " Tabela de fieldcat contendo os registros
*     IT_EXCLUDING           =
*     IT_SPECIAL_GROUPS      =
      it_sort                = t_sort               " Tabela contendo a ordenação dos registros
*     IT_FILTER              =
*     IS_SEL_HIDE            =
*     I_DEFAULT              = 'X'
*     I_SAVE                 = ' '
*     IS_VARIANT             =
*     IT_EVENTS              =
*     IT_EVENT_EXIT          =
*     IS_PRINT               =
*     IS_REPREP_ID           =
*     I_SCREEN_START_COLUMN  = 0
*     I_SCREEN_START_LINE    = 0
*     I_SCREEN_END_COLUMN    = 0
*     I_SCREEN_END_LINE      = 0
*     I_HTML_HEIGHT_TOP      = 0
*     I_HTML_HEIGHT_END      = 0
*     IT_ALV_GRAPHICS        =
*     IT_HYPERLINK           =
*     IT_ADD_FIELDCAT        =
*     IT_EXCEPT_QINFO        =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER =
    tables
      t_outtab               = t_saida              " Tabela de impressão dos registros
    exceptions
      program_error          = 1
      others                 = 2.
  if sy-subrc <> 0.
    message text-007 type 'I'.
    stop.
  endif.

endform.

form cabecalho.

  CLEAR w_header.
  REFRESH t_header.

  w_header-typ = 'H'.
  w_header-info = text-008.
  append w_header to t_header.

  w_header-typ  = 'S'.
  w_header-key  = text-009.
  write sy-datum to w_header-info.
  append w_header to t_header.

  w_header-typ = 'S'.
  w_header-key = text-010.
  write sy-uzeit to w_header-info.
  append w_header to t_header.

  call function 'REUSE_ALV_COMMENTARY_WRITE'
    exporting
      it_list_commentary = t_header
      i_logo             = 'ENJOYSAP_LOGO'
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .


endform.