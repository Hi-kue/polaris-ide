import { Module } from '@nestjs/common';
import { AuthGoogleService } from './google.service';
import { ConfigModule } from '@nestjs/config';
import { AuthGoogleController } from './google.controller';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [ConfigModule, AuthModule],
  providers: [AuthGoogleService],
  exports: [AuthGoogleService],
  controllers: [AuthGoogleController],
})
export class AuthGoogleModule {}
