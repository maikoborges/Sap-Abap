* Declaração da tabela transparente
tables zt005.

* Tela de seleção contendo o dois parâmetros de seleção no modo select-options
selection-screen begin of block b01 with frame title text-001.
select-options: s_mater for zt005-mater,
                s_tpmat for zt005-tpmat.
selection-screen end of block b01.

* Declaração das estruturas das tabelas internas
types: begin of ty_tabela1,
         tpmat like zt005-tpmat,
         mater like zt005-mater,
         denom like zt005-denom,
         brgew like zt005-brgew,
         ntgew like zt005-ntgew,
       end of ty_tabela1.

types: begin of ty_tabela2,
         segm   like zt001-denom,
         tpmat1 like zt001-tpmat,
       end of ty_tabela2.

* Declaração das work areas e tabelas internas
data: w_area1 type ty_tabela1,
      w_area2 type ty_tabela2,
      t_zt005 type table of ty_tabela1,
      t_zt001 type table of ty_tabela2.

start-of-selection.
* Declaração dos performs
  perform selecao_registros.
  perform leitura_registros.


form selecao_registros .
  select tpmat mater denom brgew ntgew
    from zt005
    into table t_zt005
   where tpmat in s_tpmat and mater in s_mater.

  if t_zt005[] is not initial. " Se t_zt005 não for zero, faça

* Seleção dos dados da tabela zt001 para a tabela z_zt001 caso os dados conste na tabela t_zt005
* (FOR ALL ENTRIES IN)
    select denom tpmat
        from zt001                  " Tabela de seleção dos dados
        into table t_zt001          " Tabela que receberá os dados
        for all entries in t_zt005  " Tabela que será parâmetro para seleção dos registros da zt001
       where tpmat = t_zt005-tpmat. " Seleção dos registros na TB. zt001 que estejam igual ao campo tpmat da TB. zt005
  else.
    message text-002 type 'I'.
    stop.
  endif.

endform.

form leitura_registros.

  loop at t_zt005 into w_area1.
    write: / w_area1-tpmat,
             w_area1-mater,
             w_area1-denom,
             w_area1-brgew,
             w_area1-ntgew.

    read table t_zt001 into w_area2 with key tpmat1 = w_area1-tpmat.
    if sy-subrc is initial. " Se sy-subrc é igual a zero, faça

    endif.
    write: w_area2-segm.
  endloop.

endform.