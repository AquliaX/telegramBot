package com.ontravel.telegram.service;

import com.ontravel.telegram.dao.TownRepository;
import com.ontravel.telegram.entity.Town;
import com.ontravel.telegram.exception.NullObjectException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TownServiceImpl implements TownService {

    private TownRepository townRepository;

    @Autowired
    private TownServiceImpl(TownRepository townRepository) {
        this.townRepository = townRepository;
    }

    @Override
    public Town addTown(Town town) {
        return townRepository.save(town);
    }

    @Override
    public List<Town> getAllTowns() {
        return (List<Town>) townRepository.findAll();
    }

    @Override
    public void updateTown(Integer id, Town town) {
        Optional<Town> optionalTown = townRepository.findById(id);
        if (!optionalTown.isPresent()) {
            throw new NullObjectException("Town does not exist and cannot be updated");
        }
        townRepository.save(town);
    }

    @Override
    public void deleteTown(Integer id) {
        Optional<Town> optionalTown = townRepository.findById(id);
        if (!optionalTown.isPresent()) {
            throw new NullObjectException("Town does not exist and cannot be deleted");
        }
        townRepository.deleteById(id);
    }
}
