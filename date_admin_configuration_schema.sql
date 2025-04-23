-- ==============================
-- Database Schema for DATE Project: Admin Configuration
-- ==============================

-- Drop existing tables if any (CAUTION: for development/testing)
DROP TABLE IF EXISTS preferences, settings, notifications, sms_templates, mail_templates, crop_types,
    crop_features, crops, villages, blocks, districts, states, countries,
    module_access, modules, role_permissions, permissions, users, roles CASCADE;

-- ==============================
-- Roles & Permissions
-- ==============================

CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE permissions (
    permission_id SERIAL PRIMARY KEY,
    permission_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE role_permissions (
    role_id INT REFERENCES roles(role_id) ON DELETE CASCADE,
    permission_id INT REFERENCES permissions(permission_id) ON DELETE CASCADE,
    PRIMARY KEY (role_id, permission_id)
);

-- ==============================
-- Users
-- ==============================

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role_id INT REFERENCES roles(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- Modules and Module Access
-- ==============================

CREATE TABLE modules (
    module_id SERIAL PRIMARY KEY,
    module_name VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE module_access (
    role_id INT REFERENCES roles(role_id),
    module_id INT REFERENCES modules(module_id),
    access_level VARCHAR(50), -- View / Edit / Full
    PRIMARY KEY (role_id, module_id)
);

-- ==============================
-- Country, State, District, Village
-- ==============================

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100),
    country_code VARCHAR(10)
);

CREATE TABLE states (
    state_id SERIAL PRIMARY KEY,
    state_name VARCHAR(100),
    country_id INT REFERENCES countries(country_id)
);

CREATE TABLE districts (
    district_id SERIAL PRIMARY KEY,
    district_name VARCHAR(100),
    state_id INT REFERENCES states(state_id)
);

CREATE TABLE blocks (
    block_id SERIAL PRIMARY KEY,
    block_name VARCHAR(100),
    district_id INT REFERENCES districts(district_id)
);

CREATE TABLE villages (
    village_id SERIAL PRIMARY KEY,
    village_name VARCHAR(100),
    block_id INT REFERENCES blocks(block_id)
);

-- ==============================
-- Crop Management
-- ==============================

CREATE TABLE crops (
    crop_id SERIAL PRIMARY KEY,
    crop_name VARCHAR(100)
);

CREATE TABLE crop_features (
    feature_id SERIAL PRIMARY KEY,
    feature_name VARCHAR(100),
    crop_id INT REFERENCES crops(crop_id)
);

CREATE TABLE crop_types (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(100),
    feature_id INT REFERENCES crop_features(feature_id)
);

-- ==============================
-- Templates
-- ==============================

CREATE TABLE mail_templates (
    mail_id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    subject VARCHAR(150),
    body TEXT
);

CREATE TABLE sms_templates (
    sms_id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    message TEXT
);

-- ==============================
-- Notifications
-- ==============================

CREATE TABLE notifications (
    notification_id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    message TEXT,
    user_id INT REFERENCES users(user_id),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- Settings & Preferences
-- ==============================

CREATE TABLE settings (
    setting_id SERIAL PRIMARY KEY,
    setting_name VARCHAR(100),
    setting_value TEXT
);

CREATE TABLE preferences (
    preference_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    preference_key VARCHAR(100),
    preference_value TEXT
);

-- ==============================
-- Sample Default Insert (Optional)
-- ==============================

-- Insert default role
INSERT INTO roles (role_name, description) VALUES ('Admin', 'System Administrator'), ('Manager', 'Module Manager'), ('User', 'Regular User');

-- Insert permissions
INSERT INTO permissions (permission_name, description) VALUES 
('view_users', 'Can view user list'),
('edit_users', 'Can edit user details'),
('manage_roles', 'Can assign roles');

-- Map Admin to all permissions
INSERT INTO role_permissions (role_id, permission_id)
SELECT 1, permission_id FROM permissions;

-- Add a sample module
INSERT INTO modules (module_name) VALUES ('User Management'), ('Crop Settings'), ('Notifications');

-- Assign Admin full access to modules
INSERT INTO module_access (role_id, module_id, access_level)
SELECT 1, module_id, 'Full' FROM modules;
