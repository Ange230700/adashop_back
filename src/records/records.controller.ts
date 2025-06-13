// src\records\records.controller.ts

import { Controller, Get } from '@nestjs/common';
import { RecordsService } from '~/src/records/records.service';

@Controller('records')
export class RecordsController {
  constructor(private readonly recordsService: RecordsService) {}

  @Get()
  async findAll() {
    return this.recordsService.findAll();
  }
}
