package playaddition.model;

import java.io.Serializable;

public class Resta implements Serializable {
	
	private int puntos;
	private int nivel;
	private int operando1;
	private int operando2;
	private String modo;
	private int resultado1;
	private int resultado2;
	private int resultadoResta;
	
	public Resta() {
	}
	
	public Resta(int operando1, int operando2) {
		this.operando1 = operando1;
		this.operando2 = operando2;
	}
	
	public int getPuntos() {
		return puntos;
	}
	public void setPuntos(int puntos) {
		this.puntos = puntos;
	}
	public int getNivel() {
		return nivel;
	}
	public void setNivel(int nivel) {
		this.nivel = nivel;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + operando1;
		result = prime * result + operando2;
		return result;
	}
	@Override
	public String toString() {
		
		return new Integer(operando1).toString()+" + "+new Integer(operando2).toString()+ " = "+new Integer(resultadoResta).toString();
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Resta other = (Resta) obj;
		if (operando1 == other.operando1 && operando2 == other.operando2)
			return true;
		return false;
	}
	public int getOperando1() {
		return operando1;
	}
	public void setOperando1(int operando1) {
		this.operando1 = operando1;
	}
	public int getOperando2() {
		return operando2;
	}
	public void setOperando2(int operando2) {
		this.operando2 = operando2;
	}
	public String getModo() {
		return modo;
	}
	public void setModo(String modo) {
		this.modo = modo;
	}
	public int getResultado1() {
		return resultado1;
	}
	public void setResultado1(int resultado1) {
		this.resultado1 = resultado1;
	}
	public int getResultado2() {
		return resultado2;
	}
	public void setResultado2(int resultado2) {
		this.resultado2 = resultado2;
	}
	public int getResultadoResta() {
		return resultadoResta;
	}
	public void setResultadoResta(int resultadoResta) throws Exception{
		if (resultadoResta<0)
			throw new Exception("Resta negativa: "+this.getOperando1()+" "+this.getOperando2() );
		this.resultadoResta = resultadoResta;
	}
}
