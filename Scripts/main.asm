asect 0x00

start:
    ldi r0, DIRECT
    ld r0, r0           # r0 = DIRECT (00, 01, 10 или 11)
    
    # Проверка на DOWN (00)
    if
        tst r0              # проверка на 0
    is z
        # ДВИЖЕНИЕ ВНИЗ: увеличить Y
        ldi r1, HEAD_Y
        ld r1, r1
        inc r1
        # Проверка границы: если >15, то 0
        ldi r3, 15
		if
        	cmp r1, r3
        is gt
            clr r1
        fi
        ldi r2, HEAD_Y
        st r2, r1
    fi
    
    # Проверка на RIGHT (01)
    ldi r1, 01
    if
        cmp r0, r1
    is z
        # ДВИЖЕНИЕ ВПРАВО: увеличить X
        ldi r1, HEAD_X
        ld r1, r1
        inc r1
        # Проверка границы: если >15, то 0
        ldi r3, 15
		if
        	cmp r1, r3
        is gt
            clr r1
        fi
        ldi r2, HEAD_X
        st r2, r1
    fi
    
    # Проверка на LEFT (10)
    ldi r1, 02          # 10 в двоичной = 2 в десятичной
    if
        cmp r0, r1
    is z
        # ДВИЖЕНИЕ ВЛЕВО: уменьшить X
        ldi r1, HEAD_X
        ld r1, r1
        dec r1
        # Проверка границы: если <0, то 15
		if
        	tst r1
        is lt
            ldi r1, 15
        fi
        ldi r2, HEAD_X
        st r2, r1
    fi
    
    # Проверка на UP (11)
    ldi r1, 03          # 11 в двоичной = 3 в десятичной
    if
        cmp r0, r1
    is z
        # ДВИЖЕНИЕ ВВЕРХ: уменьшить Y
        ldi r1, HEAD_Y
        ld r1, r1
        dec r1
        # Проверка границы: если <0, то 15
		if
        					tst r1
        is lt
            ldi r1, 15
        fi
        ldi r2, HEAD_Y
        st r2, r1
    fi

	ldi r0, HEAD_X
	ld r0, r0           # r0 = текущий X
	ldi r1, OUT_X        # АДРЕС 0xF0, а не значение из памяти!
	ld r1, r1
	st r1, r0           # сохраняем X по адресу 0xF0
    
    ldi r0, HEAD_Y
	ld r0, r0           # r0 = текущий Y
	ldi r1, OUT_Y       # АДРЕС 0xF1
	ld r1, r1
	st r1, r0           # сохраняем Y по адресу 0xF1

    # Вывод X на шину out
    ldi r0, OUT_X
	ld r0, r0
    ld r0, r0           # r0 = X
    #move r0, r0         # просто чтобы выставить значение на шину out

    # Вывод Y на шину out
    ldi r0, OUT_Y
	ld r0, r0
    ld r0, r0           # r0 = Y
    #move r0, r0         # выставляем Y на шину

	br start
    


HEAD_X:   dc 0
HEAD_Y:   dc 0
LENGTH:   dc 1
DIRECT:   dc 0    # 00-вниз, 01-вправо, 10-влево, 11-вверх

OUT_X:    dc 0xF0  # сюда будет скопирован X
OUT_Y:    dc 0xF1  # сюда будет скопирован Y 

end