SELECTION-SCREEN: BEGIN OF BLOCK bloco WITH FRAME TITLE text-001.
  PARAMETERS: med1 TYPE p DECIMALS 2,
              med2 TYPE p DECIMALS 2.
SELECTION-SCREEN: END OF BLOCK bloco.

DATA: tot TYPE p DECIMALS 2.

tot = med1 * med2.

WRITE: / 'A metragem Quadrada é',tot.