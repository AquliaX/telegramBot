package com.ontravel.telegram.controller;

import com.ontravel.telegram.converter.TownConverter;
import com.ontravel.telegram.dto.TownDto;
import com.ontravel.telegram.service.TownService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/main")
public class MainController {

    private TownService townService;
    private TownConverter townConverter;

    @Autowired
    private MainController(TownService townService, TownConverter townConverter) {
        this.townService = townService;
        this.townConverter = townConverter;
    }

    @GetMapping
    public ModelAndView getMainForm() {
        ModelAndView model = new ModelAndView("mainForm");
        List<TownDto> list = townService.getAllTowns()
                .stream()
                .map(town -> townConverter.fromTownToDto(town))
                .collect(Collectors.toList());
        model.addObject("townsList", list);
        return model;
    }
}
