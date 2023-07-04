tables zt005.

selection-screen begin of block b01 with frame title text-001.
select-options: s_tpmat for zt005-tpmat,
                s_mater for zt005-mater.
selection-screen end of block b01.

types: begin of ty_dados,
         tpmat  like zt001-tpmat,
         mater  like zt005-mater,
         denom  like zt005-denom,
         categ  like zt001-denom,
         brgew  like zt005-brgew,
         ntgew  like zt005-ntgew,
         gewei  like zt005-gewei,
         status like zt005-status,
       end of ty_dados.

data: w_area  type ty_dados,
      t_mater type table of ty_dados.

perform selecao_dados.
perform cabecalho.
perform leitura_registros.

form selecao_dados .
* Seleciona todos os registros do campo de ligação entre as tabelas contidos na tabela informada no from
  select zt001~tpmat, zt005~mater, zt005~denom, zt001~denom, zt005~brgew, zt005~ntgew, zt005~gewei, zt005~status
    from zt001
    left join zt005                 " Associação das tabelas zt001 e zt005
      on zt001~tpmat = zt005~tpmat  " Campo de ligação entre as tabelas
    into table @t_mater
   where zt001~tpmat in @s_tpmat and zt005~mater in @s_mater.

endform.

form cabecalho .
  format color 6.
  write: /1 '|',
          2 'Tipo de Material',
         19 '|',
         20 'Material',
         30 '|',
         31 'Denominação',
         45 '|',
         46 'Categoria',
         60 '|',
         61 'Peso Bruto',
         75 '|',
         76 'Peso Líquido',
         90 '|',
         91 'Unidade',
        100 '|',
        101 'Status',
        110 '|'.

  uline /(110).
  format reset.

endform.

form leitura_registros .

  loop at t_mater into w_area.
    write: /1 '|',
              2 w_area-tpmat,
             19 '|',
             20 w_area-mater,
             30 '|',
             31 w_area-denom,
             45 '|',
             46 w_area-categ,
             60 '|',
             61 w_area-brgew,
             75 '|',
             76 w_area-ntgew,
             90 '|',
             91 w_area-gewei,
            100 '|',
            101 w_area-status,
            110 '|'.

    uline /(110).
  endloop.

endform.