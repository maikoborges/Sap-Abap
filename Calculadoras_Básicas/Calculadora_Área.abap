SELECTION-SCREEN: BEGIN OF BLOCK bloco WITH FRAME TITLE text-001.
  PARAMETERS: p_med1 TYPE p DECIMALS 2,
              p_med2 TYPE p DECIMALS 2.
SELECTION-SCREEN: END OF BLOCK bloco.

DATA: v_tot TYPE p DECIMALS 2.

v_tot = p_med1 * p_med2.

WRITE: / 'A metragem Quadrada é',v_tot.