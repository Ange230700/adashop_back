// src\records\records.controller.ts

import {
  Controller,
  Get,
  Param,
  NotFoundException,
  ParseIntPipe,
} from '@nestjs/common';
import { RecordsService } from '~/src/records/records.service';

@Controller('records')
export class RecordsController {
  constructor(private readonly recordsService: RecordsService) {}

  @Get()
  async findAll() {
    return this.recordsService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number) {
    const record = await this.recordsService.findOne(id);
    if (!record) {
      throw new NotFoundException(`Record with id ${id} not found`);
    }
    return record;
  }
}
