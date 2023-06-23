SELECTION-SCREEN: BEGIN OF BLOCK bloco WITH FRAME TITLE text-001.
  PARAMETERS: p_val   TYPE p DECIMALS 2,
              p_porc TYPE i.
SELECTION-SCREEN: END OF BLOCK bloco.

DATA: v_tot TYPE p DECIMALS 2 LENGTH 3.

v_tot = ( p_val * p_porc ) / 100.

WRITE: 'O valor percentual é:',v_tot.