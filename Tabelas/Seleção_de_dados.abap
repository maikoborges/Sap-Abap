tables t005u.

selection-screen begin of block b01 with frame title text-001.
select-options: s_land1 for t005u-land1,
                s_bland for t005u-bland.
selection-screen end of block b01.

selection-screen begin of block b02 with frame title text-002.
parameters p_spras like t005u-spras default 'EN'.
selection-screen end of block b02.

types: begin of ty_dados,
         ty_land1 like t005u-land1,
         ty_bland like t005u-bland,
         ty_bezei like t005u-bezei,
       end of ty_dados.

data: w_area  type ty_dados,
      t_t005u type table of ty_dados.

* Declaração do INITIALIZATION
INITIALIZATION.       " Executado antes da exibição da tela de seleção, aplicado para tratamento de variáveis e outros
s_land1-sign   = 'I'.
s_land1-option = 'EQ'.
s_land1-low    = 'BR'.
APPEND s_land1.

perform selecao_registros.

* Declaração do START-OF-SELECTION
START-OF-SELECTION.   " Executado após a tela de exibição e antes da impressãodos dados
perform cabecalho.
perform leitura_registros.


form selecao_registros .
  select land1 bland bezei from t005u into table t_t005u
         where land1 in s_land1 and bland in s_bland and spras = p_spras.
endform.

form cabecalho .
  format color 5.
  write: /1 '|',
          2 'País',
          6 '|',
          7 'Região',
         14 '|',
         15 'Denominação',
         30 '|'.

  uline /(30).
  format reset.
endform.

form leitura_registros .
  loop at t_t005u into w_area.
    write: /1 '|',
            2 w_area-ty_land1,
            6 '|',
            7 w_area-ty_bland,
           14 '|',
           15 w_area-ty_bezei,
           30 '|'.

    uline /(30).
  endloop.

endform.