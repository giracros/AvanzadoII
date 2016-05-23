package control;

import java.util.List;
import org.hibernate.Session;

import modelo.Nomina;
import utilidad.HibernateUtil;

@SuppressWarnings("hiding")
public class NominaDAO<Object> {

	private static final Session session = HibernateUtil.getSessionFactory().openSession();

	/*
	 * Metodo de Insertar 
	 */
	public void insertar(Nomina nomina) {

		try {
			session.getTransaction().begin();
			session.save(nomina);
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		} finally {
			session.flush();
		}
	}

	/*
	 * Metodo de Listar 
	 */
	public List<Object> listar() {
		List<Object> nominas = null;
		try {
			session.getTransaction().begin();
			nominas = (List<Object>) session.createCriteria(Nomina.class).list();
			session.getTransaction().commit();
		} catch (Exception e) {
			session.flush();
			session.getTransaction().rollback();
		}
		return nominas;
	}

	
	/*
	 * Metodo de Eliminar 
	 */
	public void eliminar(Nomina nomina) {

		try {
			session.getTransaction().begin();
			session.delete(nomina);
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		} finally {
			session.flush();
		}
	}

	/*
	 * Metodo de Modificar 
	 */
	public void modificar(Nomina nomina) {
		try {
			session.getTransaction().begin();
			session.update(nomina);
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
		} finally {
			session.flush();
		}
	}
}
