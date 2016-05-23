# Avanzado II - Daniel Fuentes

+ Final Avanzado II - CUR 2016

Este es un crud el cual esta utilizando Hibernate - Mojarra - Primefaces y Maven

Que tiene este CRUD:

Una tabla con los siguientes campos:

+ cedula
+ empleado
+ salariomensual
+ díastrabajados
+ básico
+ auxiliotransporte
+ totaldevengado
+ eps
+ pension
+ totaldeducido
+ netopagado

-----------------

Con las siguientes reglas de negocio:

+ básico = regla de 3 que se calcula según los días trabajados
+ auxiliotransporte = se pagan 77700 mensuales a los empleados que ganan menos de dos salarios minimos (un minimo es 689454), este pago es proporcional a los días trabajados
+ totaldevengado = básico + auxilio
+ eps = 4% del básico
+ pension = 5% del básico
+ totaldeducido = eps + pension
+ netopagado = totaldevengado - totaldeducido

-----------------

~~~
    set new.basico = ((new.diastrabajados * new.salariomensual) /30);
    set new.totaldevengado= (new.basico + new.auxiliodetransporte);
    set new.eps=(new.basico*0.04);
    set new.pension=(new.basico * 0.05);
    set new.totaldeducido=(new.eps + new.pension);
    set new.totaldevengado=(new.basico + new.auxiliodetransporte);
    set new.netopagado = (new.totaldevengado - new.totaldeducido);
    if (new.auxiliodetransporte<13789000)then
       set new.auxiliodetransporte=((77700 *new.diastrabajados)/30);
       else
       set new.auxiliodetransporte= 0;
    end if;
~~~

Gracias
