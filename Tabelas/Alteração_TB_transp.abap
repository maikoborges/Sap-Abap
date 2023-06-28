message-id zc0001.

* Tabela transparente
tables zt001.

* Parâmetros de seleção
parameters: tpmat  like zt001-tpmat obligatory,
            denom  like zt001-denom obligatory,
            insert radiobutton group gr1,
            update radiobutton group gr1,
            modify radiobutton group gr1,
            delete radiobutton group gr1.

* Em caso de adição de registros
if insert = 'X'.
  clear zt001.
  zt001-tpmat = tpmat.
  zt001-denom = denom.
  insert zt001.

  if sy-subrc = 0.
    commit work.    " Confirmação da rotina no banco de dados
    message s002.
  else.
    rollback work.
    message i003.
  endif.

* Em caso de atualização dos registros
elseif update = 'X'.
  update zt001
  set   denom = denom
  where tpmat = tpmat.

  if sy-subrc = 0.
    commit work.
    message s004.
  else.
    rollback work.
    message s005.
  endif.

* Em caso de modificação dos registros
elseif modify = 'X'.
  clear zt001.
  zt001-tpmat = tpmat.
  zt001-denom = denom.
  modify zt001.

  if sy-subrc = 0.
    commit work.
    message s006.
  else.
    rollback work.
    message i007.
  endif.

* Em caso de Exclusão dos registros
elseif delete = 'X'.                     
  delete from zt001 where tpmat = tpmat. 

  if sy-subrc = 0.                      
    commit work.                        
    message s008.                       
  else.
    rollback work.                      
    message i009.                      
  endif.
endif.