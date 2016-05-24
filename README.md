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
CREATE TRIGGER `Tr_Calculo` BEFORE INSERT ON `Nomina` FOR EACH ROW BEGIN

  declare  salarioMinimo INT;
  set salarioMinimo  = 689454;
   SET new.Basico = ((new.DiasTrabajados * new.SalarioMensual) / 30);
   SET new.TotalDevengado = (new.Basico + new.AuxilioTransporte);
   SET new.Eps = (new.Basico * 0.04);
   SET new.Pension = (new.Basico * 0.05);
   SET new.TotalDeducido = (new.Eps + new.Pension);


   IF (new.SalarioMensual < salarioMinimo*2)
   THEN
      SET new.AuxilioTransporte = ((77700 * new.DiasTrabajados) / 30);
   ELSE
      SET new.AuxilioTransporte = 0;
   END IF;

   SET new.TotalDevengado = (new.Basico + new.AuxilioTransporte);
   SET new.NetoPagado = (new.TotalDevengado - new.TotalDeducido);
END
~~~

Gracias
