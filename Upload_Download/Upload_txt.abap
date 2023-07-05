* Estrutura da tabela
types: begin of ty_txt,
         codigo type c length 10,
         nome   type c length 30,
         telef  type c length 14,
       end of ty_txt.

* Declação da tabela interna e work area
data: w_area_txt type ty_txt,
      t_txt      type table of ty_txt.

* Tela de Seleção
selection-screen begin of block b01 with frame title text-001.
parameters: p_txt type localfile.        " Elemento de dado para seleção do arquivo
selection-screen end of block b01.

" Evento SELECTION-SCREEN ativado após click no metcold do elemento p_file

at selection-screen on value-request for p_txt. " VALUE-REQUEST retorna um pedido de ativação do evento
  perform selecao_arquivo. " Perform de seleção do arquivo

* Evento de Inicio de exercução das rotinas
start-of-selection.
  perform upload.   " Perform de carregamento dos regitros
  perform leitura.  " Perform de leitura da tabela interna

form selecao_arquivo .

  call function 'KD_GET_FILENAME_ON_F4' " Chamando a função (KD_GET_FILENAME_ON_F4) que serve para seleção de arquivo
    exporting
*     PROGRAM_NAME  = SYST-REPID
*     DYNPRO_NUMBER = SYST-DYNNR
      field_name    = p_txt      " Local de origem do arquivo
*     STATIC        = ' '
*     MASK          = ' '
*     FILEOPERATION = 'R'
*     PATH          =
    changing
      file_name     = p_txt      " Seleção do arquivo
*     LOCATION_FLAG = 'P'
    exceptions
      mask_too_long = 1
      others        = 2.

  if sy-subrc <> 0.
    message text-002 type 'I'.
  endif.


endform.

form upload.

  data vl_txt type string.
  vl_txt = p_txt.             " Transformando o arquivo em string para se adquar ao pedido na função

  call function 'GUI_UPLOAD'    " Função de carregamento de dados do arquivo para uma tabela interna
    exporting
      filename                = vl_txt        " Passagem do nome e local do arquivo a ser carregado (EM STRING)
      filetype                = 'ASC'          " Forma de leitura dos dados, texto (ASD)
*     HAS_FIELD_SEPARATOR     = ' '
*     HEADER_LENGTH           = 0
*     READ_BY_LINE            = 'X'
*     DAT_MODE                = ' '
*     CODEPAGE                = ' '
*     IGNORE_CERR             = ABAP_TRUE
*     REPLACEMENT             = '#'
*     CHECK_BOM               = ' '
*     VIRUS_SCAN_PROFILE      =
*     NO_AUTH_CHECK           = ' '
* IMPORTING
*     FILELENGTH              =
*     HEADER                  =
    tables
      data_tab                = t_txt          " Passagem da tabela que receberam os dados carregados do arquivo
* CHANGING
*     ISSCANPERFORMED         = ' '
    exceptions
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      others                  = 17.

  if sy-subrc <> 0.
    message text-003 type 'I'.
  endif.


endform.

form leitura .
  loop at t_txt into w_area_txt.
    write: / w_area_txt-codigo,
             w_area_txt-nome,
             w_area_txt-telef.
  endloop.
endform.