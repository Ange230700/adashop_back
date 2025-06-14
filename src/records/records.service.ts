// src\records\records.service.ts

import { Injectable } from '@nestjs/common';
import prisma from '~/prisma/lib/prismaClient';

@Injectable()
export class RecordsService {
  async findAll() {
    return prisma.entity_table.findMany();
  }

  findOne(id: number) {
    return prisma.entity_table.findUnique({ where: { id } });
  }
}
