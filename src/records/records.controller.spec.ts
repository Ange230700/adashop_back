// src/records/records.controller.spec.ts

import { Test, TestingModule } from '@nestjs/testing';
import { RecordsController } from '~/src/records/records.controller';
import { RecordsService } from '~/src/records/records.service';

describe('RecordsController', () => {
  let controller: RecordsController;
  let service: RecordsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [RecordsController],
      providers: [
        {
          provide: RecordsService,
          useValue: { findAll: jest.fn() },
        },
      ],
    }).compile();

    controller = module.get<RecordsController>(RecordsController);
    service = module.get<RecordsService>(RecordsService);
  });

  describe('findAll', () => {
    it('should return an array of records', async () => {
      const mockRecords = [
        {
          id: 1,
          field_1: 'foo',
          field_2: true,
          field_3: 42,
          field_4: new Date('2025-06-01T00:00:00Z'),
        },
      ];
      jest.spyOn(service, 'findAll').mockResolvedValue(mockRecords);

      await expect(controller.findAll()).resolves.toBe(mockRecords);
      expect(service.findAll).toHaveBeenCalled();
    });
  });
});
