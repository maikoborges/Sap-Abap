
* Módulo de tratamento dos botões
module botoes input.

  case sy-ucomm.
    when 'BACK' or 'EXIT' or 'CANCEL'. " Sair da tela
      leave program.

    when 'EXECUTAR'.                   " Selecionar registros 
      PERFORM selecionar_registros.

    when 'ADD'.                        " Adicionar registro de atrasos
      PERFORM inserir_registros.
      PERFORM selecionar_registros.

  endcase.

endmodule.