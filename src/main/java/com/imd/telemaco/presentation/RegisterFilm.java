/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imd.telemaco.presentation;

import com.imd.telemaco.business.FilmServices;
import com.imd.telemaco.entity.Audiovisual;
import com.imd.telemaco.presentation.audiovisual.RegisterAudiovisual;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author franklin
 */
public class RegisterFilm extends RegisterAudiovisual {

    @Override
    public void init() {
        this.services = new FilmServices();
    }

    @Override
    protected Audiovisual setAudiovisualValues(HttpServletRequest request) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }   
}
