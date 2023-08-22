
form salva_dados .

    clear zt006.
    move-corresponding w_zt006 to zt006.    " Move os dados da w_zt006 para tb transp. zt006
    modify zt006.                           " Modificar a tabela transparente zt006
  
    clear zt007.
    loop at t_zt007.
      move-corresponding t_zt007 to zt007.  " Move os dados da t_zt007 para tb transp. zt007
      zt007-numpd = w_zt006-numpd.          " Add dados do n°pedido na tb transparente zt007
      modify zt007.                         " Modificar a tabela transparente zt007
    endloop.
  
    commit work.                            " Confirmar a inclusão dos dados na tabela transparente
  
    if sy-subrc is initial.
      message text-004 type 'I'.
      clear w_zt006.                        " Limpar o cabeçalho do module pool
      refresh t_zt007.                      " Limpar a tabela de pedido do module pool
    endif.
  endform.