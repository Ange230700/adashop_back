// prisma\helpers\cleanUp.ts

import prisma from '~/prisma/lib/prismaClient';
import safeDelete from '~/prisma/helpers/deleteSafely';

async function cleanUp() {
  await safeDelete(() => prisma.entity_table.deleteMany({}), 'entity_table');
}

export default cleanUp;
