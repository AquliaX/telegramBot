package com.ontravel.telegram.converter;

import com.ontravel.telegram.dto.TownDto;
import com.ontravel.telegram.entity.Town;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class TownConverterImpl implements TownConverter {
    @Override
    public TownDto fromTownToDto(Town town) {
        TownDto townDto = new TownDto();
        BeanUtils.copyProperties(town, townDto);
        return townDto;
    }

    @Override
    public Town fromDtoToTown(TownDto townDto) {
        Town town = new Town();
        BeanUtils.copyProperties(townDto, town);
        return town;
    }
}
