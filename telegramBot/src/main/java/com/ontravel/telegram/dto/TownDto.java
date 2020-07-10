package com.ontravel.telegram.dto;

import javax.validation.constraints.NotBlank;

public class TownDto {

    private Integer id;

    @NotBlank(message = "Name cannot be null")
    private String name;

    @NotBlank(message = "Info cannot be null")
    private String info;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
