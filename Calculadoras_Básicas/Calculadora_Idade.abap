SELECTION-SCREEN: BEGIN OF BLOCK bloco WITH FRAME TITLE text-001.
  PARAMETERS: nome TYPE c LENGTH 40,
              nasc  TYPE n LENGTH 4.
SELECTION-SCREEN: END OF BLOCK bloco.

DATA: idade TYPE n LENGTH 2.

idade = sy-datum(4) - nasc.
WRITE: / 'O Sr.(a):',nome,
       / 'Tem',idade,'anos'.