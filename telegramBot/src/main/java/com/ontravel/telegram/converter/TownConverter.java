package com.ontravel.telegram.converter;

import com.ontravel.telegram.dto.TownDto;
import com.ontravel.telegram.entity.Town;

public interface TownConverter {

    TownDto fromTownToDto(Town town);

    Town fromDtoToTown(TownDto townDto);
}
