SELECTION-SCREEN: BEGIN OF BLOCK bloco WITH FRAME TITLE text-001.
  PARAMETERS: p_dist     TYPE p DECIMALS 2,
              p_vl_lt    TYPE p DECIMALS 2,
              p_km_lt    TYPE p DECIMALS 2.
SELECTION-SCREEN: END OF BLOCK bloco.

DATA: v_qtd_lt TYPE p DECIMALS 2 LENGTH 3,
      v_valor  TYPE p DECIMALS 2 LENGTH 3.

v_qtd_lt = p_dist / p_km_lt.
v_valor  = v_qtd_lt * p_vl_lt.

WRITE: / 'Quantidade de Combustível gasto:', v_qtd_lt,
       / 'Valor total Gasto:',v_valor.