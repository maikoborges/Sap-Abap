
***   PBO   ***
process before output.

* Módulo de tratamento do cabeçalho
  module status_0100.

* Módulo para tratamento da subscreen na saida
  module tb_0100_tb_set.

* Chamando a subscreen que recebe o número da tela e nome do programa
  call subscreen ref1 including w_tb_0100-progr
                                w_tb_0100-subscreen.

* Módulo de tratamento do valor total do cabeçalho
  module calcula_total.

  " Loop de tratamento da tabela t_zt007
  loop at t_zt007 with control tc_0100. " loop da t_zt007 na tc_0100
  endloop.


***   PAI   ***
process after input.

* Chamando a subscreen para apresentação
  call subscreen ref1.

* Módulo para tratamennto da subscreen na entrada
  module tb_0100_tb_get.

* Modulo de saida de tela
  module exit_0100 at exit-command. "Comando para os botões de saida

* Loop de apresentação da tabela t_zt007
  loop at t_zt007.
    chain.              " Permite a validação dos campos dentro do loop
      field t_zt007-itmpd.
      field t_zt007-mater.
      field t_zt007-quant.
      field t_zt007-meins.
      field t_zt007-vlunt.
      field t_zt007-waers.
    endchain.
* Módulo de tratamento do campo mark (campo de marcação da table cont.)
    field t_zt007-mark module mark on request.
  endloop.

* Módulo de tratamento dos botões de inserir e deletar
  module user_command_0100.