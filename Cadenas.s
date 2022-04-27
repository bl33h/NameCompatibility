/* -----------------------------------------------
* UNIVERSIDAD DEL VALLE DE GUATEMALA
* Sara Maria Perez Echeverria 21371
* Fabian Estuardo Juarez Tello 21440
* Organización de computadoras y Assembler
* Ciclo 1 - 2022
*
* Programa que determina la compatibilidad del
* primer nombre con el primer apellido y la buena
* fortuna del individuo en base a un sistema de
* puntaje basado en 3 diferentes criterios.
 ----------------------------------------------- */
    @@ codigo de assembler: se coloca en la seccion .text
.text
.align 2
    @@ etiqueta "main" llama a la funcion global
.global main
.type main, %function
main:
    @@ grabar registro de enlace en la pila
stmfd sp!, {lr}
/*impresion de menu y pide comando*/
Menu:
    ldr r0,=menu
    bl puts
    ldr r0,=opcion
    ldr r1,=comando
    bl scanf

/*compara comandos*/
comp:
/*saltos dependiendo de caracter*/
    ldr r4,=comando
    ldrb r4,[r4]
    cmp r4, #'s'
    beq ejecucion
    cmpne r4, #'q'
    beq Salir
    bne ErrorCar

 /* ejecucion */
    ejecucion:
    @Nombre
    ldr r0,=ingresoN
    bl puts
    ldr r0,=entrada
    ldr r1,=n
    bl scanf
    @Apellido
    ldr r0,=ingresoA
    bl puts
    ldr r0,=entrada
    ldr r1,=a
    bl scanf
    /*@calculo
    *ldr r6, =op1
    *ldr r8,[r6]
    *ldr r7,=op2
    *ldr r7,[r7]
    *add r8,r7
    @guarda valor
    *str r8,[r6]
    *ldr r0,=res
    *ldr r1,=op1
    *ldr r1,[r1]
    *bl printf
    */
    b Salir

/* salto para error de comando*/
ErrorCar:
ldr r0,=error
bl puts
bl getchar
b Menu

/* si pone q sale*/
Salir:
ldr r0,=adios
bl puts
mov r0, #0
mov r3, #0
ldmfd sp!, {lr}
bx lr
.data
.align 2

n: .asciz "  "
a: .asciz "  "
f: .word 0

menu:
    .asciz "------- Bienvenido a MiPrimerBebe.com -------\n A continuacion ingrese el posible nombre y apellido de su bebe y evaluaremos la fortuna que este tendria considerando los siguientes criterios:\n- Ambos nombre y apellido tienen la misma cantidad de letras\n- Ambos nombre y apellido tienen el mismo número de vocales\n- Ambos nombre y apellido terminan con la exacta misma letra\nEl nombre sera aprobado si su puntuacion es mayor que 2.\n\n--- COMANDOS ---\n(s) Ejecutar el programa\n(q) Salir"
opcion:
    .asciz " %c"
comando:
    .byte 0
entrada:
    .asciz " %s"
ingresoN:
    .asciz "Ingrese su nombre: "
ingresoA:
    .asciz "Ingrese su apellido: "
error:
    .asciz "Ingreso incorrecto"
adios:
    .asciz "Hasta pronto"
 /*"\null"*/
