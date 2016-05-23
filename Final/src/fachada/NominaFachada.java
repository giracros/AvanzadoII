package fachada;

import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import control.NominaDAO;
import modelo.Nomina;

@ManagedBean
@SessionScoped
public class NominaFachada {

	private Nomina nomina = new Nomina();
	private NominaDAO nominaDAO = new NominaDAO();

	public Nomina getNomina() {
		return nomina;
	}

	public void setNomina(Nomina nomina) {
		this.nomina = nomina;
	}

	public String agregar() {
		nominaDAO.insertar(nomina);
		return "NominaListar";
	}

	public List<Nomina> listar() {
		return nominaDAO.listar();
	}

	public void eliminar(Nomina nomina) {
		nominaDAO.eliminar(nomina);
	}

	public String modificar(Nomina nomina) {
		this.nomina = nomina;
		return "NominaModificar";
	}

	public String modificar() {
		nominaDAO.modificar(nomina);
		return "NominaListar";
	}
}