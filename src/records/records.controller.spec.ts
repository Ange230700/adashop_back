// src/records/records.controller.spec.ts

import { Test, TestingModule } from '@nestjs/testing';
import { RecordsController } from '~/src/records/records.controller';
import { RecordsService } from '~/src/records/records.service';
import { faker } from '@faker-js/faker';

describe('RecordsController', () => {
  let controller: RecordsController;
  let service: RecordsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [RecordsController],
      providers: [
        {
          provide: RecordsService,
          useValue: { findAll: jest.fn(), findOne: jest.fn() },
        },
      ],
    }).compile();

    controller = module.get<RecordsController>(RecordsController);
    service = module.get<RecordsService>(RecordsService);
  });

  describe('findAll', () => {
    it('should return an array of records', async () => {
      const mockRecords = Array.from({ length: 5 }).map(() => ({
        id: faker.number.int({ min: 1, max: 1000 }),
        field_1: faker.lorem.word(),
        field_2: faker.datatype.boolean(),
        field_3: faker.number.int({ min: 0, max: 100 }),
        field_4: faker.date.recent(),
      }));
      jest.spyOn(service, 'findAll').mockResolvedValue(mockRecords);

      await expect(controller.findAll()).resolves.toBe(mockRecords);
      expect(service.findAll).toHaveBeenCalled();
    });
  });

  describe('findOne', () => {
    it('should return a single record when found', async () => {
      const mockRecord = {
        id: faker.number.int({ min: 1, max: 1000 }),
        field_1: faker.lorem.word(),
        field_2: faker.datatype.boolean(),
        field_3: faker.number.int({ min: 0, max: 100 }),
        field_4: faker.date.recent(),
      };
      jest.spyOn(service, 'findOne').mockResolvedValue(mockRecord);

      await expect(controller.findOne(mockRecord.id)).resolves.toBe(mockRecord);
      expect(service.findOne).toHaveBeenCalledWith(mockRecord.id);
    });
  });
});
