* Tabela transparente
tables zt001.

* Tabela Interna
data: t_zt001 type table of zt001,
      w_zt001 type zt001.

* Tela de seleção
selection-screen begin of block b01 with frame title text-001.
parameters: p_file type localfile.
selection-screen end of block b01.

* Evento para seleção do local de destino
AT selection-screen ON value-request for p_file.  " Evento que abrir um popup ao click no parâmetro
  perform selecao_destino.                        " Perform contendo a função de seleção de destino

* Evento de processamento das rotinas
START-OF-SELECTION.
  perform selecao_dados.                          " Perform contendo a rotina de seleção dos dados da tabela transparente
  perform download.                               " Perform contento a função de download dos dados da tabela interna

form selecao_dados.
  select * from zt001 into table t_zt001.
endform.

form download .

  data vl_file type string.
  vl_file = p_file.

  call function 'GUI_DOWNLOAD'              " Função de download dos arquivos da tabela interna
    exporting
*     BIN_FILESIZE            =
      filename                = vl_file     " Passagem do parâmetro de destino dos dados
      filetype                = 'ASC'       " Formato de download deste arquivos (texto)
*     APPEND                  = ' '
*     WRITE_FIELD_SEPARATOR   = ' '
*     HEADER                  = '00'
*     TRUNC_TRAILING_BLANKS   = ' '
*     WRITE_LF                = 'X'
*     COL_SELECT              = ' '
*     COL_SELECT_MASK         = ' '
*     DAT_MODE                = ' '
*     CONFIRM_OVERWRITE       = ' '
*     NO_AUTH_CHECK           = ' '
*     CODEPAGE                = ' '
*     IGNORE_CERR             = ABAP_TRUE
*     REPLACEMENT             = '#'
*     WRITE_BOM               = ' '
*     TRUNC_TRAILING_BLANKS_EOL       = 'X'
*     WK1_N_FORMAT            = ' '
*     WK1_N_SIZE              = ' '
*     WK1_T_FORMAT            = ' '
*     WK1_T_SIZE              = ' '
*     WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*     SHOW_TRANSFER_STATUS    = ABAP_TRUE
*     VIRUS_SCAN_PROFILE      = '/SCET/GUI_DOWNLOAD'
* IMPORTING
*     FILELENGTH              =
    tables
      data_tab                = t_zt001         " Tabela interna de onde será feito o download
*     FIELDNAMES              =
    exceptions
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      others                  = 22.

  if sy-subrc <> 0.
    message text-002 type 'I'.
  endif.

endform.

form selecao_destino .
  call function 'KD_GET_FILENAME_ON_F4'
    exporting
*     PROGRAM_NAME  = SYST-REPID
*     DYNPRO_NUMBER = SYST-DYNNR
      field_name    = p_file
*     STATIC        = ' '
*     MASK          = ' '
*     FILEOPERATION = 'R'
*     PATH          =
    changing
      file_name     = p_file
*     LOCATION_FLAG = 'P'
    exceptions
      mask_too_long = 1
      others        = 2.

  if sy-subrc <> 0.
    MESSAGE text-003 TYPE 'I'.
  endif.

endform.