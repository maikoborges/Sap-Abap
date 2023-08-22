
module status_0100 output.

  set pf-status 'PF-0100'.   " Tratamemto de botões
  set titlebar  'TL-0100'.   " Tratamento do cabeçalho

endmodule.

module calcula_total output.

  clear w_zt006-vlbru.    " Limpar o campo e valor da work area
  loop at t_zt007.
    w_zt006-vlbru = w_zt006-vlbru + ( t_zt007-quant * t_zt007-vlunt ). " Add os valores ao campo
  endloop.

endmodule.

module tb_0100_tb_set output.

  tb_0100-activetab = w_tb_0100-pressed_tab.
  case w_tb_0100-pressed_tab.
    when c_tb_0100-tab1.
      w_tb_0100-subscreen = 101.
    when c_tb_0100-tab2.
      w_tb_0100-subscreen = 102.
    when others.
  endcase.
endmodule.

module status_0101 output.

* rotina de fechamento dos campos do cabeçalho

  loop at screen.   " Leitura da tabela de tela

    if screen-name = 'W_ZT006-NUMPD' and w_zt006-numpd <> space.
      screen-input = 0. " Fechando o campo após confirma que ele não está vazio
    endif.

    if screen-name = 'W_ZT006-BUKRS' and w_zt006-bukrs <> space.
      screen-input = 0.
    endif.

    if screen-name = 'W_ZT006-FORNE' and w_zt006-forne <> space.
      screen-input = 0.
    endif.

    if screen-name = 'W_ZT006-COMPR' and w_zt006-compr <> space.
      screen-input = 0.
    endif.

    modify screen.

  endloop.
endmodule.

module status_0102 output.

* Tratamento para fechamento dos campos na tabscrip tela 102
  loop at screen.

    if screen-name = 'W_ZT006-WAERS' and w_zt006-waers <> space.
      screen-input = 0.
    endif.

    if screen-name = 'W_ZT006-PRAZO' and w_zt006-prazo <> space.
      screen-input = 0.
    endif.

    modify screen. " Modificando a tabela de tela

  endloop.

endmodule.