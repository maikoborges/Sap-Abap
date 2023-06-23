SELECTION-SCREEN: BEGIN OF BLOCK bloco WITH FRAME TITLE text-001.
  PARAMETERS: vl     TYPE p DECIMALS 2,
              qtd_pc TYPE i.
SELECTION-SCREEN: END OF BLOCK bloco.

DATA: perc      TYPE p,
      total     TYPE p DECIMALS 2,
      acre_desc TYPE p DECIMALS 2.

IF vl <= 100 AND qtd_pc = 1.
  perc      = - 15.
ELSEIF vl > 100 AND qtd_pc = 1.
  perc      = - 20.
ELSEIF vl <= 100 AND qtd_pc <= 3.
  perc      = - 5.
ELSEIF vl > 100 AND qtd_pc <= 3.
  perc      = - 10.
ELSEIF qtd_pc > 3.
  perc      = 10.
ENDIF.

acre_desc = ( ( vl * perc ) / 100 ) .
total     = vl + acre_desc.

WRITE: / 'Valor original =',vl,/,
       / 'Quantidade de Parcela(s) =',qtd_pc,/,
       / 'Percentual de Desconto/ Acréscimo(%) =',perc,/,
       / 'Valor Desconto / Acréscimo =', acre_desc,/,
       / 'Valor Final =',total.