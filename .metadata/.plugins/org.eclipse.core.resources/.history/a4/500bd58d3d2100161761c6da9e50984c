package fachada;

import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import control.NominaDAO;

@ManagedBean
@SessionScoped
public class NominaFachada {

	private TbNomina nomina = new TbNomina();
	private NominaDAO nominaDAO = new NominaDAO();

	public TbNomina getNomina() {
		return nomina;
	}

	public void setNomina(TbNomina nomina) {
		this.nomina = nomina;
	}

	public String agregar() {
		nominaDAO.insertar(nomina);
		return "NominaListar";
	}

	public List<TbNomina> listar() {
		return nominaDAO.listar();
	}

	public void eliminar(TbNomina nomina) {
		nominaDAO.eliminar(nomina);
	}

	public String modificar(TbNomina nomina) {
		this.nomina = nomina;
		return "NominaModificar";
	}

	public String modificar() {
		nominaDAO.modificar(nomina);
		return "NominaListar";
	}
}