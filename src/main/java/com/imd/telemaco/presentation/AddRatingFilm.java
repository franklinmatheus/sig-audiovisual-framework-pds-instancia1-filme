/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imd.telemaco.presentation;

import com.imd.telemaco.business.FilmServices;
import com.imd.telemaco.presentation.audiovisual.AddRatingAudiovisual;

/**
 *
 * @author franklin
 */
public class AddRatingFilm extends AddRatingAudiovisual {

    @Override
    public void init() {
        this.services = new FilmServices();
    }
    
}
