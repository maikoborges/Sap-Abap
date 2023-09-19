
* Seleção dos registros de voos
form selecionar_registros.

    
    if zatraso_voo-data_voo is initial.
        " Seleção de todos os registros de voos
      select carrid connid countryfr cityfrom airpfrom
              countryto cityto airpto fltime deptime arrtime
        from spfli
        into table t_zatraso_voo_estrutura
       where carrid in s_carrid
         and connid in s_connid
         and cityfrom in s_cityfr
         and cityto in s_cityto.
  
    else.
        " Seleção dos registros de voos com atrasos
      select spfli~carrid spfli~connid spfli~countryfr spfli~cityfrom
      spfli~airpfrom spfli~countryto spfli~cityto spfli~airpto spfli~fltime
      spfli~deptime spfli~arrtime zatraso_voo~data_voo zatraso_voo~atraso
        from spfli
       inner join zatraso_voo
          on spfli~carrid = zatraso_voo~carrid
         and spfli~connid = zatraso_voo~connid
        into table t_zatraso_voo_estrutura
       where spfli~carrid in s_carrid
         and spfli~connid in s_connid
         and spfli~carrid in s_cityfr
         and spfli~cityto in s_cityto
         and zatraso_voo~data_voo = zatraso_voo-data_voo.
  
    " Adicionar tempo de atraso ao tempo final do voo
      if sy-subrc = 0.
        loop at t_zatraso_voo_estrutura into w_zatraso_voo_estrutura.
          if w_zatraso_voo_estrutura-atraso is not initial.
            w_zatraso_voo_estrutura-arrtime = w_zatraso_voo_estrutura-arrtime + w_zatraso_voo_estrutura-atraso.
          endif.
          modify t_zatraso_voo_estrutura from w_zatraso_voo_estrutura.
        endloop.
  
      endif.
  
    endif.
  
endform.
  
* Adicionar atrasos nos registros de voos
form inserir_registros.
  
    loop at t_zatraso_voo_estrutura into w_zatraso_voo_estrutura.
      w_zatraso_voo-carrid = w_zatraso_voo_estrutura-carrid.
      w_zatraso_voo-connid = w_zatraso_voo_estrutura-connid.
      w_zatraso_voo-data_voo = zatraso_voo-data_voo.
      w_zatraso_voo-atraso   = zatraso_voo-atraso.
  
      insert zatraso_voo from w_zatraso_voo.
  
      if sy-subrc = 0.
        commit work.
        message text-002 type 'S'.
  
      else.
        rollback work.
        message text-003 type 'S' display like 'E'.
      endif.
    endloop.
  
endform.

* Montagem da tela e seus elementos  
form custom_container_alv.
  
    if custom_container is not bound.
      create object custom_container
        exporting
          container_name = 'CC_ALV'.
  
      create object alv
        exporting
          i_parent = custom_container.
  
    " Montagem do fieldcat
      call function 'LVC_FIELDCATALOG_MERGE'
        exporting
          i_structure_name = 'ZATRASO_VOO_ESTRUTURA'
        changing
          ct_fieldcat      = fieldacat.
    " Montagem do ALV
      alv->set_table_for_first_display(
        changing
          it_outtab                     = t_zatraso_voo_estrutura
          it_fieldcatalog               = fieldacat
          ).
  
    endif.
  
    alv->refresh_table_display( ).
  
endform.

* Trava campo do tempo de atraso em caso de nenhum atraso
form trava_campo .
  
    if t_zatraso_voo_estrutura is not initial.
      loop at screen.
        if screen-group1 = 'GR1'.
          screen-input = 1.
          modify screen.
        endif.
  
      endloop.
  
    else.
      loop at screen.
        if screen-group1 = 'GR1'.
          screen-input = 0.
          modify SCREEN.
        endif.
  
      endloop.
  
    endif.
  
  
endform.