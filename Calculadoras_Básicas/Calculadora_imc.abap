MESSAGE-ID ZC0001. " Classe de Mensagem ZC0001

SELECTION-SCREEN: BEGIN OF BLOCK bloco WITH FRAME TITLE text-001.
  PARAMETERS: peso TYPE p DECIMALS 2,
              alt  TYPE p DECIMALS 2.
SELECTION-SCREEN: END OF BLOCK bloco.

DATA: result TYPE p DECIMALS 2 LENGTH 3.

TRY.
  result = peso / ( alt * 2 ).
CATCH CX_SY_ZERODIVIDE.
  MESSAGE I000. "Divisão por Zero não permitida
  STOP.
ENDTRY.

IF result < '17'.
  WRITE: 'O IMC é',result,'e a situação é "MUITO ABAIXO DO PESO"'.
ELSEIF result < '18.5'.
  WRITE: 'O IMC é',result,'e a situação é "ABAIXO DO PESO"'.
ELSEIF result < '25'.
  WRITE: 'O IMC é',result,'e a situação é "PESO NORMAL"'.
ELSEIF result < '30'.
  WRITE: 'O IMC é',result,'e a situação é "ACIMA DO PESO"'.
ELSEIF result < '35'.
  WRITE: 'O IMC é',result,'e a situação é "OBESIDADE I"'.
ELSEIF result < '40'.
  WRITE: 'O IMC é',result,'e a situação é "OBESIDADE II(SEVERA)"'.
ELSE.
  WRITE: 'O IMC é',result,'e a situação é "OBESIDADE III(MÓRBIDA)"'.
ENDIF.