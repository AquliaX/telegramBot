package com.ontravel.telegram.service;

import com.ontravel.telegram.entity.Town;

import java.util.List;

public interface TownService {

    Town addTown(Town town);

    List<Town> getAllTowns();

    void updateTown(Integer id, Town order);

    void deleteTown(Integer id);
}
