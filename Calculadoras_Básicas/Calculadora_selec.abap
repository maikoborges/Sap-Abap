MESSAGE-ID ZC0001.

SELECTION-SCREEN: BEGIN OF BLOCK bloco WITH FRAME TITLE text-001.
  PARAMETERS: num1 TYPE i,
              num2 TYPE i.
  SELECTION-SCREEN SKIP.

  PARAMETERS: soma RADIOBUTTON GROUP gr1,
              subt RADIOBUTTON GROUP gr1,
              mult RADIOBUTTON GROUP gr1,
              divi RADIOBUTTON GROUP gr1.
SELECTION-SCREEN: END OF BLOCK bloco.

DATA: total TYPE i.

IF soma = 'X'.
  total = num1 + num2.
  WRITE: / 'RESULTADO',
         / 'A opção escolhida foi a soma',
         / 'Total =',total.
ELSEIF subt = 'X'.
  total = num1 - num2.
  WRITE: / 'RESULTADO',
         / 'A opção escolhida foi a subtração',
         / 'Total =',total.
ELSEIF mult = 'X'.
  total = num1 * num2.
  WRITE: / 'RESULTADO',
         / 'A opção escolhida foi a multiplicação',
         / 'Total =',total.
  ELSE.
    TRY .
      total = num1 / num2.
      WRITE: / 'RESULTADO',
             / 'A opção escolhida foi a divisão',
             / 'Total =',total.
    CATCH CX_SY_ZERODIVIDE.
      MESSAGE: I000.
    ENDTRY.
    STOP.
ENDIF.