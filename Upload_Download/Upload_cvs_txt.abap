types: begin of ty_txt,
         cod  type c length 10,
         nome type c length 30,
         cel  type c length 14,
       end of ty_txt.

types: begin of ty_csv,
         line type c length 100,
       end of ty_csv.

data: w_txt type ty_txt,
      t_txt type table of ty_txt,
      w_csv type ty_csv,
      t_csv type table of ty_csv.

selection-screen begin of block b01 with frame title text-001.
parameters: p_file type localfile,            " Declarando o elemento do Local de origem do arquivo
            p_txt  radiobutton group gr1,     " Radiobutton para seleção do tipo arquivo
            p_csv  radiobutton group gr1.
selection-screen end of block b01.


* Declaração do PONTEIRO DE MEMÓRIA (Elemento com função de camaleão, se tranformar em outros objetos)
field-symbols <tabela> type standard table.

at selection-screen on value-request for p_file.
  perform selecao_file.

start-of-selection.
  perform upload_arquivo.
  perform leitura_arquivo.

form selecao_file .

  call function 'KD_GET_FILENAME_ON_F4'
    exporting
*     PROGRAM_NAME  = SYST-REPID
*     DYNPRO_NUMBER = SYST-DYNNR
      field_name    = p_file      " Determinando o elemento que recebera o local de origem do arquivo
*     STATIC        = ' '
*     MASK          = ' '
*     FILEOPERATION = 'R'
*     PATH          =
    changing
      file_name     = p_file      " Definindo o elemento que recebera o local de origem no tratamento da função
*     LOCATION_FLAG = 'P'
    exceptions
      mask_too_long = 1
      others        = 2.

  if sy-subrc <> 0.
    message text-002 type 'I'.    " Mensagem de aviso no caso de erro
  endif.

endform.

form upload_arquivo .

* Convertendo o caminho do arquivo para TYPE STRING
  data: vl_file type string.
  vl_file = p_file.

* Declaração da condicional que radiobutton selecionado no ponteiro de memória
  if p_txt = 'X'.
    assign t_txt to <tabela>.  " Atribuindo a tabela t_txt ao field-symbols caso este seja selecionado no radiobutton
  else.
    assign t_csv to <tabela>.  " Atribuindo a tabela t_cvs ao field-symbols caso este seja selecionado no radiobutton
  endif.


  call function 'GUI_UPLOAD'
    exporting
      filename                = vl_file     " Declarando o local de origem do arquivo
      filetype                = 'ASC'        " Determinando o tipo de leitura do arquivo
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
      data_tab                = <tabela>
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

* declaração da condicional que converte o arquivo csv em arquivo txt para ser impresso
  if p_csv = 'X'.
    loop at <tabela> into w_csv.
      split w_csv at ';' into w_txt-cod w_txt-nome w_txt-cel.
      append w_txt to t_txt.
    endloop.
  endif.

endform.


form leitura_arquivo .

  loop at t_txt into w_txt.
    write: / w_txt-cod, w_txt-nome, w_txt-cel.
  endloop.


endform.