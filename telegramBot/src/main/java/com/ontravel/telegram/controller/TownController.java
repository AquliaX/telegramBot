package com.ontravel.telegram.controller;

import com.ontravel.telegram.converter.TownConverter;
import com.ontravel.telegram.dao.TownRepository;
import com.ontravel.telegram.dto.TownDto;
import com.ontravel.telegram.entity.Town;
import com.ontravel.telegram.service.TownService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@CrossOrigin
@RequestMapping("/api/towns")
public class TownController {

    private TownService townService;
    private TownConverter townConverter;
    private TownRepository townRepository;

    @Autowired
    private TownController(TownService townService, TownConverter townConverter, TownRepository townRepository) {
        this.townService = townService;
        this.townConverter = townConverter;
        this.townRepository = townRepository;
    }

    @GetMapping("/add")
    public ModelAndView showAddTownForm() {
        ModelAndView model = new ModelAndView();
        Town town = new Town();
        model.addObject(town);
        model.setViewName("town/addTown");
        return model;
    }

    @PostMapping
    public ModelAndView addTown(@ModelAttribute("townForm") Town town) {
        try {
            townService.addTown(town);
            return new ModelAndView("redirect:/api/towns");
        } catch (Exception e) {
            return new ModelAndView("redirect:/api/towns");
        }
    }

    @GetMapping
    public ModelAndView getAllTowns() {
        ModelAndView model = new ModelAndView("town/townForm");
        List<TownDto> list = townService.getAllTowns()
                .stream()
                .map(town -> townConverter.fromTownToDto(town))
                .collect(Collectors.toList());
        model.addObject("townForm", list);
        return model;
    }

    @GetMapping("/edit/{id}")
    public ModelAndView showEditForm(@PathVariable Integer id) {
        ModelAndView model = new ModelAndView();
        Town town = townRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid town Id:" + id));
        model.addObject(town);
        model.setViewName("town/editTown");
        return model;
    }

    @PostMapping("/edit/{id}")
    public ModelAndView updateTown(@PathVariable Integer id, TownDto townDto) {
        ModelAndView model = new ModelAndView();
        Town town = townConverter.fromDtoToTown(townDto);
        town.setId(id);
        townService.updateTown(id, town);
        model.addObject(town);
        model.setViewName("town/addTown");
        return model;
    }

    @GetMapping(value = "/delete/{id}")
    public ModelAndView deleteTown(@PathVariable Integer id) {
        ModelAndView model = new ModelAndView();
        model.setViewName("redirect:/api/towns");
        townService.deleteTown(id);
        return model;
    }
}
