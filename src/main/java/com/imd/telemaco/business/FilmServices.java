/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imd.telemaco.business;

import com.imd.telemaco.business.exception.AudiovisualInvalidException;
import com.imd.telemaco.business.exception.BusinessException;
import com.imd.telemaco.business.exception.CloseConnectionException;
import com.imd.telemaco.business.exception.DatabaseException;
import com.imd.telemaco.data.FilmDAO;
import com.imd.telemaco.entity.Audiovisual;
import com.imd.telemaco.entity.Film;
import java.util.ArrayList;

/**
 *
 * @author franklin
 */
public final class FilmServices extends AudiovisualServices {

    public FilmServices() throws DatabaseException {
        this.audiovisualDAO = new FilmDAO();
    }

    @Override
    public void validate(Audiovisual audiovisual) throws AudiovisualInvalidException, DatabaseException, CloseConnectionException, BusinessException {
        Film program = (Film) this.audiovisualDAO.select(audiovisual.getName());
        if(program != null)
            throw new BusinessException("Já existe outro programa com esse nome!");
    }

    @Override
    public ArrayList<Audiovisual> recommend() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
