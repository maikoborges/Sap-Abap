*&---------------------------------------------------------------------*
*& Report ZUDEMYEXER0027
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zudemyexer0027.

* Declaração de Tabela Transparente
tables zt005.

* Declaração da Tela de Seleção
selection-screen begin of block b01 with frame title text-001.
select-options: s_tpmat for zt005-tpmat,
                s_mater for zt005-mater.
selection-screen end of block b01.

* Declaração do Tipo (ESTRUTURA DA TABELA)
types: begin of ty_mater,
         tpmat  like zt001-tpmat,
         mater  like zt005-mater,
         denom  like zt005-denom,
         categ  like zt001-denom,
         brgew  like zt005-brgew,
         ntgew  like zt005-ntgew,
         gewei  like zt005-gewei,
         status like zt005-status,
       end of ty_mater.

* Declaração da Tabela Interna e da Work Area
data: w_area  type ty_mater,          " Work area
      t_mater type table of ty_mater. " Tabela Interna

initialization.           " Evento de tratamento após a tela de seleção
* Declaração dos Performs
start-of-selection.       " Evento de inicialização da rotina
  perform selecao_dados.
  perform cabecalho.
  perform leitura_registros.


* Declaração das Rotinas nos Forms
form selecao_dados .

  select zt001~tpmat zt005~mater zt005~denom zt001~denom zt005~brgew zt005~ntgew zt005~gewei zt005~status
    from zt005
   inner join zt001                 " Associação das tabelas zt005 com a zt001
      on zt001~tpmat = zt005~tpmat  " Campo que existe em ambas e faz a liação entre as tabelas
    into table t_mater              " Tabela Interna que receberá os registros encontrados
   where zt001~tpmat in s_tpmat and zt005~mater in s_mater.

  if sy-subrc <> 0.            " Tratamento de Erro
    message text-002 type 'I'. "Nenhum Registro Encontrado.
    stop.
  endif.

endform.

form cabecalho .

  format color 4.
  write: /1 '|',
          2 'Tipo Material',
         16 '|',
         17 'Material',
         35 '|',
         36 'Denominação',
         72 '|',
         73 'Categoria',
        108 '|',
        109 'Peso Bruto',
        127 '|',
        128 'Peso Líquido',
        146 '|',
        147 'Tamanho',
        156 '|',
        157 'Status',
        163 '|'.

  uline /(163).
  format reset.

endform.

form leitura_registros.

  loop at t_mater into w_area.
    write: /1 '|',
              2 w_area-tpmat,
             16 '|',
             17 w_area-mater,
             35 '|',
             36 w_area-denom,
             72 '|',
             73 w_area-categ,
            108 '|',
            109 w_area-brgew,
            127 '|',
            128 w_area-ntgew,
            146 '|',
            147 w_area-gewei,
            156 '|',
            157 w_area-status,
            163 '|'.

    uline /(163).
  endloop.

endform.