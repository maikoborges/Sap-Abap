

PROCESS BEFORE OUTPUT.

  MODULE STATUS_0100.                                   " Módulo para habilitar botões padrão

  call subscreen tela_aux INCLUDING sy-repid '01'.      " Preparando subtela para apresentação

  MODULE custom_alv.                                    " Módulo de montagem do container e de seus elementos

PROCESS AFTER INPUT.

  call subscreen tela_aux.                              " Chamando subtela para apresentação

  MODULE botoes.                                        " Módulo de tratamento dos botões
