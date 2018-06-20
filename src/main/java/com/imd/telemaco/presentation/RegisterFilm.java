/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imd.telemaco.presentation;

import com.imd.telemaco.business.FilmServices;
import com.imd.telemaco.business.exception.DatabaseException;
import com.imd.telemaco.entity.Audiovisual;
import com.imd.telemaco.entity.Film;
import com.imd.telemaco.presentation.audiovisual.RegisterAudiovisual;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author franklin
 */
public class RegisterFilm extends RegisterAudiovisual {

    @Override
    public void init() {
        try {
            this.services = new FilmServices();
        } catch (DatabaseException ex) {
            Logger.getLogger(RegisterFilm.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected Audiovisual setAudiovisualValues(HttpServletRequest request) {
        Film program = new Film();
        program.setName(request.getParameter("name"));
        program.setGenre(request.getParameter("genre"));
        program.setClassification(program.stringToClassif(request.getParameter("classification")));
        program.setStatus(request.getParameter("status"));
        program.setYear(Integer.parseInt(request.getParameter("year")));
        program.setSynopsis(request.getParameter("synopsis"));
        program.setDuration(Integer.parseInt(request.getParameter("duration")));
        return program;
    }   
}
