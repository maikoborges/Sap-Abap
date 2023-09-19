
" Módulo para habilitar os botões padrões da tela
module status_0100 output.      
  set pf-status 'PF-100'.   
endmodule.

" Módulo para montar, tratar o ALV e os elementos da tela
module custom_alv output.       
  PERFORM custom_container_alv. " Montagem da tela e de seuus elementos

  PERFORM trava_campo.          " Travamento do campo de tempo de atraso

endmodule.