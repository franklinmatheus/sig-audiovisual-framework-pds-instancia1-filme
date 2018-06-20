/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imd.telemaco.data;

import com.imd.telemaco.business.exception.CloseConnectionException;
import com.imd.telemaco.business.exception.DatabaseException;
import com.imd.telemaco.entity.Audiovisual;
import com.imd.telemaco.entity.Film;
import com.imd.telemaco.entity.Rating;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author franklin
 */
public class FilmDAO extends AudiovisualDAO {

    public FilmDAO() throws DatabaseException {
        super();
    }

    @Override
    public void insert(Audiovisual audioVisual) throws DatabaseException, CloseConnectionException {
        String sql = "INSERT INTO telemaco.program (name, genre, classification, status, year, synopsis, image, duration) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        Film program = (Film) audioVisual;

        try {
            super.startsConnection();

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, program.getName());
            stm.setString(2, program.getGenre());
            stm.setString(3, program.classifToString());
            stm.setString(4, program.getStatus());
            stm.setInt(5, program.getYear());
            stm.setString(6, program.getSynopsis());
            stm.setString(7, program.getImage());
            stm.setInt(8, program.getDuration());

            stm.execute();
        } catch (SQLException e) {
            throw new DatabaseException();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new CloseConnectionException();
            }
        }
    }

    @Override
    public String sqlSelectId(int id) {
        return "SELECT * FROM telemaco.program WHERE id='" + id + "'";
    }

    @Override
    public Audiovisual fillAudioVisualAttributes(int id, ResultSet result) throws DatabaseException {
        Film program = new Film();
        try {
            program.setName(result.getString("name"));
            program.setGenre(result.getString("genre"));
            program.setClassification(program.stringToClassif(result.getString("classification")));
            program.setStatus(result.getString("status"));
            program.setYear(result.getInt("year"));
            program.setSynopsis(result.getString("synopsis"));
            program.setImage(result.getString("image"));
            program.setDuration(result.getInt("duration"));
            program.setId(id);
            
            RatingDAO dao = RatingDAO.getInstance();
            ArrayList<Rating> ratings = dao.selectByAudiovisual(program.getId());
            program.setRatings(ratings);
            return program;
        } catch (CloseConnectionException | DatabaseException | SQLException e) {
            throw new DatabaseException();
        }
    }

    @Override
    public String sqlSelectName(String name) {
        return "SELECT * FROM telemaco.program WHERE name='" + name + "'";
    }

    @Override
    public String sqlDelete(int id) {
        return "DELETE FROM telemaco.program WHERE id='" + id + "'";
    }

    @Override
    public void update(Audiovisual object) throws DatabaseException, CloseConnectionException {
        Film program = (Film) object;
        String sql = "UPDATE telemaco.program SET "
                + "name=?, "
                + "genre=?, "
                + "classification=?, "
                + "status=?, "
                + "year=?, "
                + "synopsis=? ,"
                + "image=? "
                + "duration=? ,"
                + "WHERE id=?";
        try {
            this.startsConnection();
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, program.getName());
            stm.setString(2, program.getGenre());
            stm.setString(3, program.classifToString());
            stm.setString(4, program.getStatus());
            stm.setInt(5, program.getYear());
            stm.setString(6, program.getSynopsis());
            stm.setString(7, program.getImage());
            stm.setInt(8, program.getDuration());
            stm.setInt(9, program.getId());

            stm.execute();
        } catch (SQLException e) {
            throw new DatabaseException();
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new CloseConnectionException();
            }
        }
    }

    @Override
    public String sqlSearch(String input) {
        return "SELECT * from telemaco.program WHERE LOWER(name) LIKE '%" + input.toLowerCase() + "%'";
    }

    @Override
    public String sqlSellectAllAudioVisual() {
        return "SELECT * FROM telemaco.program";
    }

}
