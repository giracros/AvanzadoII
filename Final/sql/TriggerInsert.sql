CREATE TRIGGER `Final`.`Tr_Calculo`
   BEFORE INSERT
   ON `Final`.`Nomina`
   FOR EACH ROW
BEGIN
	
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