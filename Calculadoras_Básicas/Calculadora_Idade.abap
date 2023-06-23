SELECTION-SCREEN: BEGIN OF BLOCK bloco WITH FRAME TITLE text-001.
  PARAMETERS: p_nome  TYPE c LENGTH 40,
              p_nasc  TYPE n LENGTH 4.
SELECTION-SCREEN: END OF BLOCK bloco.

DATA: v_idade TYPE n LENGTH 2.

v_idade = sy-datum(4) - p_nasc.
WRITE: / 'O Sr.(a):',p_nome,
       / 'Tem',v_idade,'anos'.