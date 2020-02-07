package com.cinema.dto;

import java.io.Serializable;

public class Session implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int idFilm;
	private String hourIni;
	private String hourEnd;
	private boolean clubArmChair;
	
	
	public Session() {
	}
	
	public Session(int idFilm, String hourIni, String hourEnd, boolean clubArmChair) {
		this.idFilm = idFilm;
		this.hourIni = hourIni;
		this.hourEnd = hourEnd;
		this.clubArmChair = clubArmChair;
	}
	public int getIdFilm() {
		return idFilm;
	}
	public void setIdFilm(int idFilm) {
		this.idFilm = idFilm;
	}
	public String getHourIni() {
		return hourIni;
	}
	public void setHourIni(String hourIni) {
		this.hourIni = hourIni;
	}
	public String getHourEnd() {
		return hourEnd;
	}
	public void setHourEnd(String hourEnd) {
		this.hourEnd = hourEnd;
	}

	public boolean isClubArmChair() {
		return clubArmChair;
	}

	public void setClubArmChair(boolean clubArmChair) {
		this.clubArmChair = clubArmChair;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + idFilm;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Session other = (Session) obj;
		if (idFilm != other.idFilm)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Session{" +
				"idFilm=" + idFilm +
				", hourIni='" + hourIni + '\'' +
				", hourEnd='" + hourEnd + '\'' +
				", clubArmChair=" + clubArmChair +
				'}';
	}
}
