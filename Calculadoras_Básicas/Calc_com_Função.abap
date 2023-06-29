message-id zc0001.

* Declaração dos parametros de entrada
parameters: p_num1 type i,
            p_num2 type i,
            p_oper type c.

* Declaração da variável que receberam o resultado
data: v_resul type i.

* Declaração do Evento
START-OF-SELECTION.       " Evento executado no início da rotina

* Declaração dos Performs
perform executa_calculos. " Perform contendo a função de executar cálculos
perform imprimi_dados.    " Perform contendo a impressão dos dados

* Declaração do Form EXECUTA CÁLCULO (Contendo a função que executa os mesmo)
form executa_calculos .

* CHAMANDO FUNÇÃO
  call function 'Z_F001'
    exporting                       " ENTRADA
      numero1           = p_num1    " Parâmetros de Entrada
      numero2           = p_num2    " Parâmetros de Entrada
      operacao          = p_oper    " Parâmetros de Entrada
    importing                       " SAÍDA
      resultado         = v_resul   " Parâmetro de Saída
    exceptions                      " EXCEÇÕES
      divi_zero         = 1         " Exceção de Divisão por zero
      operador_invalido = 2         " Exceção de Operador inválido
      others            = 3.        " Exceções não identificadas

* TRATAMENTO DAS EXCEÇÕES
  if sy-subrc <> 0.
    if sy-subrc = 1.
      message i000.       " Divisão por zero
      stop.
    elseif sy-subrc = 2.
      message i011.       " Operador inválido
      stop.
    else.
      message i001.       " Erro! Tente Novamente
      stop.
    endif.
  endif.

endform.

* Declaração do Form de Impressão dos dados
form imprimi_dados .
  write: / text-001, v_resul.
endform.