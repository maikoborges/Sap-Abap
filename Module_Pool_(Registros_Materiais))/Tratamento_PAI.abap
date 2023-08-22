
module exit_0100 input.
  leave program. " Saida do programa
endmodule.

module mark input.

* Rotina para a limpeza do campo mark
  loop at t_zt007 where mark = 'X'.
    clear t_zt007-mark.
    modify t_zt007 index sy-tabix transporting mark.
  endloop.

* Tratamento de marcação do campo mark
* Leitura da tabela t_zt007  no indíce da tale control
  read table t_zt007 index tc_0100-current_line.
  if sy-subrc is initial.
    t_zt007-mark = 'X'.
    " Modificando o campo mark (Marcando como selecionado)
    modify t_zt007 index sy-tabix transporting mark.
  endif.
endmodule.

module user_command_0100 input.

  case sy-ucomm. " Salva o valor do botão que foi clicado na table control da tela 0100
    when 'ADD'.
      clear t_zt007.
      " Chama a tela 0200 de tamanhos definidos
      call screen 0200 starting at 5 5 ending at 50 12.
    when 'DELE'.
      " Deleta o campo selecionado no mark
      delete t_zt007 where mark = 'X'.
    when 'SALVE'.
      " Chamar o perform e tratamento do salvamento dos dados do pedido
      perform salva_dados.
  endcase.
endmodule.

module user_command_0200 input.

  if sy-ucomm = 'OK'.
    t_zt007-waers = w_zt006-waers." Campo moeda da tb pedido receba o campo moeda do cabeçalho
    append t_zt007.
    call screen 100.              " Chamar a tela 100 de volta
  elseif sy-ucomm = 'N_OK'.
    call screen 100.
  endif.

endmodule.

module valida_bukrs input.

  clear v_deno_bukrs.
  " Selecionar a descrição da empresa e alocar na variável v_deno_bukrs
  select single denom from zt002
    into v_deno_bukrs
    where bukrs = w_zt006-bukrs.

  if sy-subrc <> 0.
    message text-001 type 'E'.
  endif.

endmodule.

module valida_forne input.

  clear v_deno_forne.
  " Selecionar a descrição do fornecedor e alocar na variável v_deno_forne
  select single denom from zt004
    into v_deno_forne
    where forne = w_zt006-forne.

  if sy-subrc <> 0.
    message text-002 type 'E'.
  endif.

endmodule.

module valida_compre input.

  clear v_deno_compr.
  " Selecionar a descrição do comprador e alocar na variável v_deno_compr
  select single denom from zt003
    into v_deno_compr
    where compr = w_zt006-compr.

  if sy-subrc <> 0.
    message text-003 type 'E'.
  endif.

endmodule.

module tb_0100_tb_get input.

  case sy-ucomm.
    when c_tb_0100-tab1.
      w_tb_0100-pressed_tab = c_tb_0100-tab1.
    when c_tb_0100-tab2.
      w_tb_0100-pressed_tab = c_tb_0100-tab2.
    when others.
  endcase.

endmodule.